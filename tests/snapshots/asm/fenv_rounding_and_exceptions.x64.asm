
fenv_rounding_and_exceptions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	-0x8(%rbp), %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	-0x8(%rbp), %edx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r13 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r14
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rcx # <addr>
               	movslq	(%rcx,%rbx,4), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3c30000000000000, %rax # imm = 0x3C30000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	subsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	addsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movabsq	$0x3c90000000000000, %rax # imm = 0x3C90000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x170000000000000, %rax # imm = 0x170000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movl	$0x1, %eax
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	sqrtsd	%xmm0, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3fc0000000000000, %rax # imm = 0x3FC0000000000000
               	movsd	<rip>, %xmm1 # <addr>
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	mulss	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	sqrtss	%xmm0, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movslq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvtsd2ss	%xmm0, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvtsd2ss	%xmm0, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvtsd2ss	%xmm0, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvttsd2si	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvttsd2si	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movabsq	$-0x4030000000000000, %rdx # imm = 0xBFD0000000000000
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movsd	<rip>, %xmm2 # <addr>
               	divsd	%xmm2, %xmm1
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3 # <addr>
               	divsd	%xmm3, %xmm2
               	movsd	<rip>, %xmm3 # <addr>
               	movsd	<rip>, %xmm4 # <addr>
               	divsd	%xmm4, %xmm3
               	movapd	%xmm1, %xmm4
               	movapd	%xmm3, %xmm6
               	movapd	%xmm2, %xmm5
               	movapd	%xmm0, %xmm3
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	movb	$0x7, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3fefffffffffffff, %rax # imm = 0x3FEFFFFFFFFFFFFF
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	mulss	%xmm1, %xmm0
               	callq	<addr>
               	movl	$0x800, %edi            # imm = 0x800
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x800, %rax            # imm = 0x800
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x800, %rax            # imm = 0x800
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x5, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rdi
               	movl	$0x4, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rdi
               	movl	$0x3d, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x2, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x3, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x7ff0000000000001, %rax # imm = 0x7FF0000000000001
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x50(%rbp)
               	movsd	-0x50(%rbp), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movl	%eax, -0x48(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movl	-0x48(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	comisd	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, -0x38(%rbp)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	%eax, -0x30(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movl	-0x38(%rbp), %esi
               	movl	-0x30(%rbp), %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x28(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movsd	-0x28(%rbp), %xmm0
               	callq	<addr>
               	movsd	-0x28(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	jmp	<addr>
               	leaq	<rip>, %r8
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	jmp	<addr>

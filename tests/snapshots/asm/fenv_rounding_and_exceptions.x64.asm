
fenv_rounding_and_exceptions.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<f>:
               	subq	$0x18, %rsp
               	subq	$0x10, %rsp
               	movq	%rdi, %rsi
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %edx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	addq	$0x10, %rsp
               	addq	$0x18, %rsp
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>

<main>:
               	subq	$0x88, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x10, %rsp
               	movl	$0x3d, %edi
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3 # <addr>
               	movsd	<rip>, %xmm4 # <addr>
               	divsd	%xmm4, %xmm3
               	movsd	<rip>, %xmm4 # <addr>
               	vxorpd	<rip>, %xmm4, %xmm4 # <addr>
               	movsd	<rip>, %xmm5 # <addr>
               	divsd	%xmm5, %xmm4
               	movsd	<rip>, %xmm5 # <addr>
               	movsd	<rip>, %xmm6 # <addr>
               	divsd	%xmm6, %xmm5
               	movsd	<rip>, %xmm6 # <addr>
               	movsd	<rip>, %xmm7 # <addr>
               	divsd	%xmm7, %xmm6
               	movb	$0x7, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jge	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r13 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rbx,8), %r14
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
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopw	(%rax,%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vaddsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	subsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	vxorpd	<rip>, %xmm1, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopw	(%rax,%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
                                                # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopw	(%rax,%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vsubsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nop
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	sqrtsd	%xmm0, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vdivsd	<rip>, %xmm0, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	vxorpd	<rip>, %xmm2, %xmm2 # <addr>
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
                                                # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
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
               	vxorpd	<rip>, %xmm2, %xmm2 # <addr>
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movslq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nop
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
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
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
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
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvttsd2si	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	cvttsd2si	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nop
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nop
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax,%rax)
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nop
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %r12 # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	nopl	(%rax)
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nop
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	mulss	%xmm1, %xmm0
               	callq	<addr>
               	movl	$0x800, %edi            # imm = 0x800
               	callq	<addr>
               	movl	$0x20, %edi
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
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
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
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
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	leaq	0x38(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	0x38(%rsp), %rdi
               	movl	$0x3d, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x20, %edi
               	callq	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
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
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
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
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x2, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x10, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x3, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x20, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movabsq	$0x7ff0000000000001, %rax # imm = 0x7FF0000000000001
               	movq	%rax, 0x58(%rsp)
               	leaq	0xa8(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movsd	0xa8(%rsp), %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	0xa8(%rsp), %xmm0
               	movsd	0xa8(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movl	%eax, 0x68(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	movl	0x68(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0x70(%rsp), %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	comisd	%xmm0, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	movl	%eax, 0x78(%rsp)
               	movsd	0x70(%rsp), %xmm0
               	movsd	0x70(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	%eax, 0x80(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	movl	0x78(%rsp), %esi
               	movl	0x80(%rsp), %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x88(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movsd	0x88(%rsp), %xmm0
               	movq	%xmm0, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x88(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x90(%rsp)
               	movsd	0x90(%rsp), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	sqrtsd	%xmm0, %xmm0
               	movsd	%xmm0, 0x98(%rsp)
               	movsd	0x98(%rsp), %xmm0
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	vmulsd	<rip>, %xmm0, %xmm0 # <addr>
               	cvttsd2si	%xmm0, %rax
               	movq	%rax, 0xa0(%rsp)
               	movq	0xa0(%rsp), %rax
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	testb	$0x1, %al
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	testb	$0x4, %al
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x8, %al
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x10, %al
               	je	<addr>
               	leaq	<rip>, %r8 # <addr>
               	testb	$0x20, %al
               	je	<addr>
               	leaq	<rip>, %r9 # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>

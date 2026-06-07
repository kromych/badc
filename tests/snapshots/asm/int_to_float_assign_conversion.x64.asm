
int_to_float_assign_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x64, %edx
               	movb	%dl, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xc8, %edx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x18(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x20(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x10(%rbp,%riz), %xmm0
               	cvtsi2sd	%rcx, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	mulss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movss	-0x18(%rbp,%riz), %xmm0
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	mulss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movss	-0x20(%rbp,%riz), %xmm0
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	mulss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x7d0, %rax            # imm = 0x7D0
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzbq	0x1(%rcx), %rcx
               	cvtsi2sd	%rcx, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movl	$0x64, %eax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	mulss	%xmm1, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x2710, %rax           # imm = 0x2710
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fd322d0e5604189, %rax # imm = 0x3FD322D0E5604189
               	movss	-0x10(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x3fe2c8b439581062, %rcx # imm = 0x3FE2C8B439581062
               	movss	-0x18(%rbp,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm1, %xmm15
               	movq	%rcx, %xmm1
               	mulsd	%xmm15, %xmm1
               	movq	%rax, %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x3fbd2f1a9fbe76c9, %rax # imm = 0x3FBD2F1A9FBE76C9
               	movss	-0x20(%rbp,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rax, %xmm14
               	movapd	%xmm1, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4060000000000000, %rax # imm = 0x4060000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x30(%rbp,%riz), %xmm0
               	movabsq	$0x4045800000000000, %rax # imm = 0x4045800000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movss	-0x30(%rbp,%riz), %xmm0
               	movabsq	$0x4046000000000000, %rax # imm = 0x4046000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x40(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x40(%rbp,%riz), %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)

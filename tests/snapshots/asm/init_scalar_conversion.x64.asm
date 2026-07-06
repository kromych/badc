
init_scalar_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rect_ok>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x408a400000000000, %rax # imm = 0x408A400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsd	0x18(%rax,%riz), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x348, %ebx            # imm = 0x348
               	movl	$0x21c, %r12d           # imm = 0x21C
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	cvtsi2sd	%rbx, %xmm0
               	leaq	-0x20(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	cvtsi2sd	%r12, %xmm0
               	leaq	-0x20(%rbp), %rax
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x20(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x408a400000000000, %rax # imm = 0x408A400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	leaq	-0x40(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x40(%rbp), %rax
               	movsd	%xmm0, 0x8(%rax,%riz)
               	cvtsi2sd	%rbx, %xmm0
               	leaq	-0x40(%rbp), %rax
               	movsd	%xmm0, 0x10(%rax,%riz)
               	cvtsi2sd	%r12, %xmm0
               	leaq	-0x40(%rbp), %rax
               	movsd	%xmm0, 0x18(%rax,%riz)
               	leaq	-0x40(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x408a400000000000, %rax # imm = 0x408A400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsd	0x18(%rax,%riz), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	cvtsi2sd	%rbx, %xmm0
               	leaq	-0x50(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	cvtsi2sd	%r12, %xmm0
               	leaq	-0x50(%rbp), %rax
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x50(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x408a400000000000, %rax # imm = 0x408A400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400f333333333333, %rax # imm = 0x400F333333333333
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movsd	-0x58(%rbp,%riz), %xmm0
               	cvttsd2si	%xmm0, %rax
               	leaq	-0x60(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x7, %eax
               	leaq	-0x60(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x60(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x68(%rbp,%riz)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movsd	-0x58(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x70(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x70(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movss	%xmm0, -0x68(%rbp,%riz)
               	movss	-0x68(%rbp,%riz), %xmm0
               	movl	$0x4078f5c3, %eax       # imm = 0x4078F5C3
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movss	-0x68(%rbp,%riz), %xmm0
               	movl	$0x407a3d71, %eax       # imm = 0x407A3D71
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	leaq	-0x98(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x98(%rbp), %rax
               	movsd	%xmm0, 0x8(%rax,%riz)
               	cvtsi2sd	%rbx, %xmm0
               	leaq	-0x98(%rbp), %rax
               	movsd	%xmm0, 0x10(%rax,%riz)
               	cvtsi2sd	%r12, %xmm0
               	leaq	-0x98(%rbp), %rax
               	movsd	%xmm0, 0x18(%rax,%riz)
               	leaq	-0x98(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)

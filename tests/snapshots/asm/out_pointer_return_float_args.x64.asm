
out_pointer_return_float_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkf4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm1, 0x4(%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm2, 0x8(%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm3, 0xc(%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movsd	0x8(%rcx,%riz), %xmm1
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<mkf5>:
               	popq	%r10
               	subq	$0x60, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	movq	%r8, 0x40(%rsp)
               	movq	%r9, 0x50(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	0x20(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x8(%rbp,%riz)
               	movq	0x30(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x10(%rbp,%riz)
               	movq	0x40(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x18(%rbp,%riz)
               	movq	0x50(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x20(%rbp,%riz)
               	movq	0x60(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x28(%rbp,%riz)
               	leaq	-0x40(%rbp), %rax
               	movss	-0x8(%rbp,%riz), %xmm0
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x40(%rbp), %rax
               	movss	-0x10(%rbp,%riz), %xmm0
               	movss	%xmm0, 0x4(%rax,%riz)
               	leaq	-0x40(%rbp), %rax
               	movss	-0x18(%rbp,%riz), %xmm0
               	movss	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x40(%rbp), %rax
               	movss	-0x20(%rbp,%riz), %xmm0
               	movss	%xmm0, 0xc(%rax,%riz)
               	leaq	-0x40(%rbp), %rax
               	movss	-0x28(%rbp,%riz), %xmm0
               	movss	%xmm0, 0x10(%rax,%riz)
               	movq	0x10(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq

<mkd3>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movsd	0x20(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	movsd	0x30(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	movsd	0x40(%rbp,%riz), %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movl	$0x3f800000, %ebx       # imm = 0x3F800000
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %ecx       # imm = 0x40800000
               	movq	%rbx, %xmm0
               	movq	%rsi, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rcx, %xmm3
               	callq	<addr>
               	movsd	%xmm0, -0xa8(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	leaq	-0xa8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rdi
               	movl	$0x3fc00000, %ebx       # imm = 0x3FC00000
               	movq	%rbx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	-0xe8(%rbp), %rsi
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	-0xf0(%rbp), %rdx
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xf8(%rbp)
               	movq	-0xf8(%rbp), %rcx
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x100(%rbp)
               	movq	-0x100(%rbp), %r8
               	movl	$0x40b00000, %eax       # imm = 0x40B00000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x108(%rbp)
               	movq	-0x108(%rbp), %r9
               	callq	<addr>
               	leaq	-0xd8(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movzbq	0x10(%rax), %rdx
               	movb	%dl, 0x10(%rcx)
               	movzbq	0x11(%rax), %rdx
               	movb	%dl, 0x11(%rcx)
               	movzbq	0x12(%rax), %rdx
               	movb	%dl, 0x12(%rcx)
               	movzbq	0x13(%rax), %rdx
               	movb	%dl, 0x13(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movss	0x10(%rax,%riz), %xmm0
               	movl	$0x40b00000, %eax       # imm = 0x40B00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	-0x140(%rbp), %rdi
               	movabsq	$0x4024000000000000, %rbx # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rdx # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rcx # imm = 0x403E000000000000
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x140(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4034000000000000, %rax # imm = 0x4034000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x403e000000000000, %rax # imm = 0x403E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>


struct_multi_byval.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take_many>:
               	popq	%r10
               	subq	$0x80, %rsp
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%r8, -0x20(%rbp)
               	movq	0x90(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x98(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0xa0(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xa8(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0xb0(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	addq	%rdx, %rcx
               	addq	%r9, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x10(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rdx
               	movslq	0x14(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	0x80(%rbp), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x80, %rsp
               	pushq	%r11
               	retq

<make2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	0x1(%rdi), %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<make4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x1(%rdi), %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x2(%rdi), %rcx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x3(%rdi), %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<make6>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x2, %rcx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x20(%rbp), %rcx
               	addq	$0x5, %rcx
               	movl	%ecx, 0x14(%rax)
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
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x30(%rbp), %r8
               	movl	$0x7d0, %r9d            # imm = 0x7D0
               	leaq	-0x48(%rbp), %rax
               	movl	$0xbb8, %ebx            # imm = 0xBB8
               	subq	$0x30, %rsp
               	movq	%rbx, 0x28(%rsp)
               	movq	%r8, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	%rcx, %r8
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	movq	(%r8), %r8
               	callq	<addr>
               	addq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1a12, %rax           # imm = 0x1A12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	movl	$0x32, %eax
               	leaq	-0xc8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0xc8(%rbp), %rax
               	movl	$0x33, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0xc8(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x50(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x32, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x33, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	movl	$0x3c, %eax
               	leaq	-0xe0(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x3d, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x3e, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x3f, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x3d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x3f, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x110(%rbp), %rdi
               	movl	$0x46, %esi
               	callq	<addr>
               	leaq	-0x110(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x90(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x46, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x47, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x48, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x49, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x4a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x4b, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x50(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x148(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x148(%rbp), %rcx
               	incq	%rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x148(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xb0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x65, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x66, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
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
               	jmp	<addr>
               	addb	%al, (%rax)

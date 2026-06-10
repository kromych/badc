
designated_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x270, %esi            # imm = 0x270
               	callq	<addr>
               	ud2
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
               	subq	$0xc0, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x14, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movzbq	0x10(%rcx), %r11
               	movb	%r11b, 0x10(%rax)
               	movzbq	0x11(%rcx), %r11
               	movb	%r11b, 0x11(%rax)
               	movzbq	0x12(%rcx), %r11
               	movb	%r11b, 0x12(%rax)
               	movzbq	0x13(%rcx), %r11
               	movb	%r11b, 0x13(%rax)
               	popq	%r11
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	popq	%r11
               	leaq	-0x70(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movslq	0x1c(%rax), %rax
               	cmpq	$0x2bc, %rax            # imm = 0x2BC
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	movslq	0x24(%rax), %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)

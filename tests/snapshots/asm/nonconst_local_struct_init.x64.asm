
nonconst_local_struct_init.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x2a, %ebx
               	movl	$0x63, %r12d
               	leaq	-0x18(%rbp), %r8
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	leaq	-0x18(%rbp), %r8
               	movl	%ebx, (%r8)
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	%r12d, (%rdi)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0x2a, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xa0(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x63, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %r8
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %rsi
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rdx
               	movq	%r8, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rdx)
               	popq	%r11
               	movl	$0x7, %edx
               	leaq	-0x20(%rbp), %rax
               	movl	%edx, (%rax)
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x4, %rsi
               	movl	%r12d, (%rsi)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rsi
               	cmpq	$0x63, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x20(%rbp), %rsi
               	movslq	(%rsi), %rdx
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %r8
               	movq	%rdx, %rsi
               	movq	%r8, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r8)
               	popq	%r11
               	movl	$0xb, %r8d
               	leaq	-0x28(%rbp), %rax
               	movl	%r8d, (%rax)
               	movl	$0x16, %edx
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0xb, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb0(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rdx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rdx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rdx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rdx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rdx)
               	popq	%r11
               	leaq	-0x38(%rbp), %rdx
               	movl	%ebx, (%rdx)
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x38(%rbp), %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x2a, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xc0(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x63, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x38(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	-0x38(%rbp), %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rax
               	leaq	-0x38(%rbp), %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	%r12d, (%rcx)
               	leaq	-0x48(%rbp), %rdx
               	movl	%ebx, (%rdx)
               	leaq	-0x48(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xd0(%rbp)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x0, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x48(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rdx
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	movq	%rax, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movl	$0x5, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
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
               	leaq	-0x58(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x58(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	%r12d, (%rcx)
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xe0(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %rcx
               	movq	%rcx, -0xd8(%rbp)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rcx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rcx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rcx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rcx)
               	popq	%r11
               	leaq	-0x78(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rcx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rcx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rcx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rcx)
               	popq	%r11
               	leaq	-0x78(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	%r12d, (%rcx)
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xf0(%rbp)
               	jmp	<addr>
               	movq	-0xf0(%rbp), %rcx
               	movq	%rcx, -0xe8(%rbp)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0xe8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x78(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)

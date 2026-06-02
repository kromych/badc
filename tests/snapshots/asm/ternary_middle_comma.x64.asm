
ternary_middle_comma.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	popq	%rax
               	movl	$0x2a, %ebx
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r9
               	cmpq	$0x80, %r9
               	jae	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	%rbx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8)
               	movl	$0x1, %edi
               	movq	%rdi, -0x88(%rbp)
               	jmp	<addr>
               	movl	$0x63, %edi
               	movq	%rdi, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movslq	%edi, %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	xorq	$0x2a, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movslq	%edi, %rsi
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi), %rdx
               	movq	%r9, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%rdx)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%rdx)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%rdx)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%rdx)
               	popq	%r11
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdx
               	cmpq	$0x80, %rdx
               	jae	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	movl	$0x1, %esi
               	movq	%rsi, -0x98(%rbp)
               	jmp	<addr>
               	movl	$0x63, %esi
               	movq	%rsi, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xa0(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%esi, %rax
               	leaq	-0x20(%rbp), %rsi
               	movzbq	(%rsi), %rdx
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movzbq	(%rsi), %rax
               	movb	%al, (%rdx)
               	movzbq	0x1(%rsi), %rax
               	movb	%al, 0x1(%rdx)
               	movzbq	0x2(%rsi), %rax
               	movb	%al, 0x2(%rdx)
               	movzbq	0x3(%rsi), %rax
               	movb	%al, 0x3(%rdx)
               	popq	%rax
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdx
               	cmpq	$0x80, %rdx
               	jae	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	movl	$0x1, %eax
               	movq	%rax, -0xa8(%rbp)
               	jmp	<addr>
               	movl	$0x63, %eax
               	movq	%rax, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xb0(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x2a, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	%edx, -0x40(%rbp)
               	movl	%edx, -0x48(%rbp)
               	movl	%edx, -0x50(%rbp)
               	cmpq	$0x0, %rbx
               	jle	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x40(%rbp)
               	movl	$0x2, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movl	$0x3, %eax
               	movl	%eax, -0x50(%rbp)
               	movslq	-0x40(%rbp), %rbx
               	movslq	-0x48(%rbp), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movslq	-0x50(%rbp), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x40(%rbp), %rdx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x50(%rbp), %rdx
               	cmpq	$0x3, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movslq	-0x40(%rbp), %rdx
               	movslq	-0x48(%rbp), %rcx
               	movslq	-0x50(%rbp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r8)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r8)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r8)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r8)
               	popq	%r11
               	movl	$0xc8, %r8d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x80, %rax
               	jae	<addr>
               	leaq	-0x60(%rbp), %rcx
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx)
               	movl	$0x1, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movl	$0x63, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	movslq	%eax, %r8
               	cmpq	$0x63, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xe0(%rbp)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xe0(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)

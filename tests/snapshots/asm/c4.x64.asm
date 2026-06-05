
c4.x64:	file format elf64-x86-64

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
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
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
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movzbq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	leaq	<rip>, %r12
               	movq	(%r12), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movq	(%r12), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rbx)
               	movq	(%rcx), %rcx
               	imulq	$0x5, %rcx, %rcx
               	movq	%rax, %rsi
               	addq	%rcx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	setle	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	setle	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rbx
               	subq	$0x1, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0x93, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rdx)
               	movzbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x6, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rbx, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	setle	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	setle	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x5f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x10, %rcx
               	movq	%rbx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rax
               	xorq	%rcx, %rcx
               	movl	$0x85, %esi
               	movq	%rsi, (%rax)
               	movq	%rsi, (%rdx)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	xorq	%rdx, %rdx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x80, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x78, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rdx)
               	movzbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x58, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rcx)
               	movzbq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x4, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	andq	$0xf, %rsi
               	addq	%rsi, %rcx
               	movq	(%rdx), %rdx
               	cmpq	$0x41, %rdx
               	jl	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x66, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x46, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x9, %esi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	addq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x3, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rdx)
               	movzbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x37, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x27, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa0, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movzbq	(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rdx)
               	movzbq	(%rsi), %rdx
               	movq	%rdx, (%rcx)
               	cmpq	$0x5c, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rdx)
               	movzbq	(%rsi), %rdx
               	movq	%rdx, (%rcx)
               	cmpq	$0x6e, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xa, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movb	%cl, (%rdx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x80, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x95, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x8e, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2b, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa2, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9d, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa3, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9e, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x96, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x99, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3c, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9b, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x97, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9a, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x3e, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9c, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x98, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x7c, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x26, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x90, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x92, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x26, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x91, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x94, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x93, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa1, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9f, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5b, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa4, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8f, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x150, %rsp            # imm = 0x150
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8c, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	andq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r14, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x81, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x3, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r14, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x7, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, %rcx
               	addq	$0x20, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r14, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%r14, %rdx
               	addq	$0x28, %rdx
               	movq	(%rdx), %rdx
               	subq	%rdx, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %rax
               	movq	%r14, %rcx
               	addq	$0x20, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x83, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r14, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r15)
               	jmp	<addr>
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%rcx, -0x8(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	subq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r14)
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x11, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xf, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %eax
               	movq	%rax, (%rcx)
               	movq	(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	imulq	$-0x1, %rax, %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa3, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	movq	(%r12), %rax
               	movq	%rax, -0x8(%rbp)
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x9, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r14)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %edx
               	jmp	<addr>
               	movl	$0x1a, %edx
               	jmp	<addr>
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
               	jmp	<addr>
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	%rbx, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	(%r12), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8f, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xc, %ecx
               	jmp	<addr>
               	movl	$0xb, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r14)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x90, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x18, %rax
               	movq	%rax, (%r14)
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x91, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x92, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xe, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x93, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xf, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x10, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x95, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x11, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x96, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x12, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x97, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x13, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x98, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x14, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x99, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x15, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9a, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x16, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9b, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x17, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x18, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x2, %rcx
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1b, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x19, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	setg	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %esi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1c, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x2, %rcx
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1b, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa0, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1c, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa1, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1d, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa3, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa4, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x9, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r14)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %edx
               	jmp	<addr>
               	movl	$0x1a, %edx
               	jmp	<addr>
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
               	jmp	<addr>
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	movl	$0x8, %edx
               	jmp	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x1a, %edx
               	jmp	<addr>
               	movl	$0x19, %edx
               	jmp	<addr>
               	movq	%rdx, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	(%r12), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1b, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x19, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rcx
               	subq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	jmp	<addr>
               	movq	%rcx, (%r14)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x89, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x87, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movq	%rcx, (%r12)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x2, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x8b, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	%r12, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %eax
               	movq	%rax, (%rcx)
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rax
               	movq	%rax, 0x10(%rbp)
               	movq	%rsi, %rax
               	movq	%rax, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	setg	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movq	0x20(%rbp), %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movq	0x20(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x73, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	setg	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movq	0x20(%rbp), %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movq	0x20(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	cmpq	$0x1, %rax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	xorq	%rsi, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movq	0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movl	$0x40000, %r12d         # imm = 0x40000
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r15)
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	xorq	%r14, %r14
               	movq	%r14, %rsi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r14, %rsi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r14, %rsi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x86, %eax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x8d, %rax
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	movl	$0x1e, %eax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x26, %rax
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movl	$0x82, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x20, %rcx
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	movl	$0x86, %ecx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	(%r14), %r14
               	leaq	<rip>, %r15
               	leaq	<rip>, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x28(%rsp), %r11
               	movq	%rax, (%r11)
               	movq	%rax, (%r15)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	%r12, %rdx
               	subq	$0x1, %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x58(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%r14, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x88, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movl	$0x80, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x20, %rcx
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x58(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	setne	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	movq	%rbx, %r15
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	setne	%r15b
               	movzbq	%r15b, %r15
               	jmp	<addr>
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %r15
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x20, %rax
               	movq	%r15, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movl	$0x81, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movl	$0x83, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %r15d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%r15, %r15
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %r15
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x30, %rcx
               	movq	(%rax), %rdx
               	addq	$0x18, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movl	$0x84, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x38, %rcx
               	movq	(%rax), %rdx
               	addq	$0x20, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x20, %rcx
               	movq	%r15, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x40, %rcx
               	movq	(%rax), %rdx
               	addq	$0x28, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	%rdx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x6, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x58(%rbp), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rdx, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	jmp	<addr>
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movq	%rbx, %r15
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %r15
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x30, %rcx
               	movq	(%rax), %rdx
               	addq	$0x18, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movl	$0x84, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x38, %rcx
               	movq	(%rax), %rdx
               	addq	$0x20, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x20, %rcx
               	movq	%r15, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x40, %rcx
               	movq	(%rax), %rdx
               	addq	$0x28, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movq	(%rax), %rdx
               	addq	$0x30, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x20, %rcx
               	movq	(%rax), %rdx
               	addq	$0x38, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x28, %rcx
               	movq	(%rax), %rax
               	addq	$0x40, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	-0x38(%rbp), %rax
               	addq	%rax, %r12
               	movq	%r12, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x26, %eax
               	movq	%rax, (%rcx)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movq	-0x38(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$-0x8, %rdx
               	movq	%rdx, (%rcx)
               	movq	0x10(%rbp), %rcx
               	movq	%rcx, (%rdx)
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$-0x8, %rdx
               	movq	%rdx, (%rcx)
               	movq	0x20(%rbp), %rcx
               	movq	%rcx, (%rdx)
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	$-0x8, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, (%rdx)
               	xorq	%rax, %rax
               	movq	%rax, -0x50(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rax
               	movq	-0x58(%rbp), %rcx
               	imulq	$0x5, %rcx, %rcx
               	movq	%rax, %rdx
               	addq	%rcx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rcx)
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	movq	%rcx, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	jmp	<addr>
               	movq	%rcx, -0x30(%rbp)
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r12, (%rcx)
               	movq	-0x38(%rbp), %r12
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r10
               	movq	%r12, %rax
               	subq	%r10, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rdx), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movq	%r12, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %r12
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movzbq	(%rax), %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rbx
               	movb	%bl, (%rax)
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xd, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x48(%rbp), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xe, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	orq	%rcx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xf, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	xorq	%rcx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	andq	%rcx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x11, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x13, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setl	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x14, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setg	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x15, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x16, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x17, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	shlq	%cl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x18, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	sarq	%cl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x19, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	addq	%rcx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1a, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1b, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	%rax, %rbx
               	imulq	%rcx, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1c, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1d, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rcx), %rax
               	movq	-0x48(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1e, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rdi
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rdi
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x20, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rdi
               	movq	%rax, %rcx
               	addq	$-0x10, %rcx
               	movq	(%rcx), %rsi
               	movq	%rax, %rcx
               	addq	$-0x18, %rcx
               	movq	(%rcx), %rdx
               	movq	%rax, %rcx
               	addq	$-0x20, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %r8
               	addq	$-0x28, %r8
               	movq	(%r8), %r8
               	addq	$-0x30, %rax
               	movq	(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x24, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rdi
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rdi
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x26, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	-0x50(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)

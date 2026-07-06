
c4.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<next>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
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
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
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
               	leaq	(%rcx,%rcx,4), %rcx
               	leaq	(%rax,%rcx), %rsi
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
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x1(%rax), %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0x93, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
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
               	movsbq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rbx, 0x10(%rcx)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	(%rax), %rax
               	xorq	%rcx, %rcx
               	movl	$0x85, %esi
               	movq	%rsi, (%rax)
               	movq	%rsi, (%rdx)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	xorq	%rdx, %rdx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rdx, %rax
               	addq	$0x10, %rsp
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
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x78, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x58, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	movsbq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x4, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	addq	%rdi, %rcx
               	cmpq	$0x41, %rsi
               	jl	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %esi
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x66, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x46, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	movl	$0x9, %esi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x3, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x37, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x27, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa0, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movsbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	movq	%rdx, (%rcx)
               	cmpq	$0x5c, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rsi
               	movq	%rsi, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movb	%cl, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x80, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x95, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x8e, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2b, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa2, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9d, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2d, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa3, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9e, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x96, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x99, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9b, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x97, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9a, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9c, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x98, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x7c, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x90, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x92, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x26, %rax
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
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x91, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
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

<expr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	testq	%rax, %rax
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
               	movq	(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %r13d
               	movq	%r13, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r13, (%rax)
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
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
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
               	testq	%rax, %rax
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
               	movl	$0x1, %edx
               	jmp	<addr>
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
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
               	xorq	%r14, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x18(%r13), %rax
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
               	incq	%r14
               	movq	(%r12), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	0x18(%r13), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r13), %rax
               	movq	%rax, (%rcx)
               	testq	%r14, %r14
               	je	<addr>
               	jmp	<addr>
               	movq	0x18(%r13), %rax
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
               	movq	0x28(%r13), %rax
               	movq	%rax, (%rcx)
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
               	movq	%r14, (%rcx)
               	leaq	<rip>, %rax
               	movq	0x20(%r13), %rcx
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
               	movq	0x28(%r13), %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	movq	0x18(%r13), %rax
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
               	movq	0x28(%r13), %rdx
               	subq	%rdx, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	0x20(%r13), %rdx
               	movq	%rdx, (%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movq	0x18(%r13), %rax
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
               	movq	0x28(%r13), %rax
               	movq	%rax, (%rcx)
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
               	movl	$0xa, %edx
               	jmp	<addr>
               	movl	$0x9, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movl	$0x1, %r13d
               	jmp	<addr>
               	xorq	%r13, %r13
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %r13
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r13, (%rax)
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
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
               	movl	$0xa, %edx
               	jmp	<addr>
               	movl	$0x9, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x1b, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa3, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%r12), %r13
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
               	movl	$0x8, %edx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0xa2, %r13
               	jne	<addr>
               	movl	$0x19, %edx
               	jmp	<addr>
               	movl	$0x1a, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	%rbx, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	movq	(%r12), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%r13, (%rax)
               	testq	%r13, %r13
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
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %r13
               	movq	%r13, (%rax)
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
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x18, %rax
               	movq	%rax, (%r13)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	leaq	0x8(%rax), %r13
               	movq	%r13, (%r14)
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
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
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r13), %rax
               	leaq	0x8(%rax), %r14
               	movq	%r14, (%r13)
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x91, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r13), %rax
               	leaq	0x8(%rax), %r14
               	movq	%r14, (%r13)
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x92, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xe, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x93, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xf, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x10, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x95, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x11, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x96, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x12, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x97, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x13, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x98, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x14, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x99, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x15, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9a, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x16, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9b, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x17, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x18, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
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
               	movq	%r13, (%rax)
               	cmpq	$0x2, %r13
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
               	cmpq	$0x2, %r13
               	setg	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r13
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	leaq	<rip>, %rax
               	movq	%r13, (%rax)
               	cmpq	$0x2, %r13
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x1b, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa0, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x1c, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa1, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r13
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r13), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	movl	$0x1d, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa3, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movl	$0x8, %edx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
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
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
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
               	cmpq	$0x2, %r13
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x19, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x2(%r13), %rdx
               	movq	%rdx, (%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %r13
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
               	movl	$0xa, %edx
               	jmp	<addr>
               	movl	$0x9, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<stmt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %r12
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
               	leaq	0x8(%rcx), %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x8(%rax), %r12
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
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	leaq	0x8(%rax), %r13
               	movq	%r13, (%rbx)
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
               	movq	%rax, (%r13)
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
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-0x1(%rdi), %rbx
               	leaq	0x8(%rsi), %r12
               	testq	%rbx, %rbx
               	setg	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r12), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%r12), %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x73, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	decq	%rbx
               	addq	$0x8, %r12
               	testq	%rbx, %rbx
               	setg	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r12), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%r12), %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x64, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	decq	%rbx
               	addq	$0x8, %r12
               	cmpq	$0x1, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movq	(%r12), %rdi
               	xorq	%rsi, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r13
               	testq	%r13, %r13
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r12), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x40000, %r14d         # imm = 0x40000
               	leaq	<rip>, %r15
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r15)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %r15
               	leaq	<rip>, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x48(%rsp), %r10
               	movq	%rax, (%r10)
               	movq	%rax, (%r15)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %r15
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r15)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r15
               	testq	%r15, %r15
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	xorq	%r10, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x40000, %edx          # imm = 0x40000
               	movq	0x48(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x40000, %edx          # imm = 0x40000
               	movq	0x48(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x40000, %edx          # imm = 0x40000
               	movq	0x48(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x86, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpq	$0x8d, %rax
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x48(%rsp), %rcx
               	incq	%rcx
               	movq	0x48(%rsp), %r11
               	movq	%r11, (%rax)
               	movq	%rcx, 0x48(%rsp)
               	jmp	<addr>
               	movl	$0x1e, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpq	$0x26, %rax
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x82, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	0x48(%rsp), %rcx
               	incq	%rcx
               	movq	0x48(%rsp), %r11
               	movq	%r11, 0x28(%rax)
               	movq	%rcx, 0x48(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %rax
               	movl	$0x86, %ecx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	<rip>, %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	<rip>, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x38(%rsp), %r10
               	movq	%rax, (%r10)
               	movq	0x40(%rsp), %r10
               	movq	%rax, (%r10)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movslq	%r13d, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movl	$0x3ffff, %edx          # imm = 0x3FFFF
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movslq	%r13d, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %r13d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0x48(%rsp), %r10
               	movq	0x28(%r10), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%r13, %r13
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x40(%rsp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
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
               	movl	$0x80, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	0x38(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x38(%rsp), %r11
               	movq	%r11, 0x28(%rax)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	%r13, 0x40(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x40(%rsp), %r10
               	addq	$0x2, %r10
               	movq	%r10, 0x40(%rsp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x20(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x81, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, 0x28(%rax)
               	callq	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x83, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	(%rcx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x38(%rsp), %r10
               	addq	$0x2, %r10
               	movq	%r10, 0x38(%rsp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x84, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	0x38(%rsp), %r11
               	movq	%r11, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	movq	0x40(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x38(%rsp), %r11
               	movq	%r11, 0x40(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x40(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r11
               	movq	%r11, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	subq	%r10, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %r13d
               	jmp	<addr>
               	xorq	%r13, %r13
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movq	%r13, 0x38(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x38(%rsp), %r10
               	addq	$0x2, %r10
               	movq	%r10, 0x38(%rsp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x84, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	0x38(%rsp), %r11
               	movq	%r11, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	movq	0x40(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x40(%rcx), %rax
               	movq	%rax, 0x28(%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	(%r15,%r14), %r13
               	leaq	-0x8(%r13), %rax
               	movl	$0x26, %ecx
               	movq	%rcx, (%rax)
               	addq	$-0x8, %rax
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rax), %rcx
               	movq	%rbx, (%rcx)
               	addq	$-0x8, %rcx
               	movq	%r12, (%rcx)
               	leaq	-0x8(%rcx), %r12
               	movq	%rax, (%r12)
               	xorq	%rbx, %rbx
               	leaq	0x8(%rsi), %r14
               	movq	(%rsi), %r15
               	incq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	(%r15,%r15,4), %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %r15
               	jg	<addr>
               	jmp	<addr>
               	testq	%r15, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	0x8(%r14), %rsi
               	movq	(%r14), %rax
               	shlq	$0x3, %rax
               	addq	%r13, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x1, %r15
               	jne	<addr>
               	leaq	0x8(%r14), %rsi
               	movq	(%r14), %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x2, %r15
               	jne	<addr>
               	movq	(%r14), %rsi
               	jmp	<addr>
               	cmpq	$0x3, %r15
               	jne	<addr>
               	addq	$-0x8, %r12
               	leaq	0x8(%r14), %rax
               	movq	%rax, (%r12)
               	movq	(%r14), %rsi
               	jmp	<addr>
               	cmpq	$0x4, %r15
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	0x8(%r14), %rsi
               	jmp	<addr>
               	movq	(%r14), %rsi
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x6, %r15
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r14), %rsi
               	jmp	<addr>
               	leaq	0x8(%r14), %rsi
               	jmp	<addr>
               	leaq	-0x8(%r12), %rax
               	movq	%r13, (%rax)
               	leaq	0x8(%r14), %rsi
               	movq	(%r14), %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %r12
               	subq	%rcx, %r12
               	movq	%rax, %r13
               	jmp	<addr>
               	cmpq	$0x7, %r15
               	jne	<addr>
               	leaq	0x8(%r14), %rsi
               	movq	(%r14), %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x8, %r15
               	jne	<addr>
               	leaq	0x8(%r13), %rax
               	movq	(%r13), %r13
               	leaq	0x8(%rax), %r12
               	movq	(%rax), %rsi
               	jmp	<addr>
               	cmpq	$0x9, %r15
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	%r14, %rsi
               	jmp	<addr>
               	cmpq	$0xa, %r15
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movsbq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0xb, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0xc, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	movb	%dl, (%rcx)
               	movsbq	%dl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0xd, %r15
               	jne	<addr>
               	addq	$-0x8, %r12
               	movq	-0x48(%rbp), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	cmpq	$0xe, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0xf, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x10, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x11, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x12, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x13, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x14, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setg	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x15, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setle	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x16, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x17, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x18, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x19, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1a, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1b, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1c, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1d, %r15
               	jne	<addr>
               	leaq	0x8(%r12), %rax
               	movq	(%r12), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1e, %r15
               	jne	<addr>
               	movq	0x8(%r12), %rdi
               	movq	(%r12), %rax
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x1f, %r15
               	jne	<addr>
               	movq	0x10(%r12), %rax
               	movslq	%eax, %rdi
               	movq	0x8(%r12), %rsi
               	movq	(%r12), %rax
               	movslq	%eax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x20, %r15
               	jne	<addr>
               	movq	(%r12), %rax
               	movslq	%eax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x21, %r15
               	jne	<addr>
               	movq	0x8(%r14), %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	leaq	-0x8(%rax), %rcx
               	movq	(%rcx), %rdi
               	leaq	-0x10(%rax), %rcx
               	movq	(%rcx), %rsi
               	leaq	-0x18(%rax), %rcx
               	movq	(%rcx), %rdx
               	leaq	-0x20(%rax), %rcx
               	movq	(%rcx), %rcx
               	leaq	-0x28(%rax), %r8
               	movq	(%r8), %r8
               	addq	$-0x30, %rax
               	movq	(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x22, %r15
               	jne	<addr>
               	movq	(%r12), %rax
               	movslq	%eax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x23, %r15
               	jne	<addr>
               	movq	(%r12), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$0x24, %r15
               	jne	<addr>
               	movq	0x10(%r12), %rdi
               	movq	0x8(%r12), %rax
               	movslq	%eax, %rsi
               	movq	(%r12), %rax
               	movslq	%eax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x25, %r15
               	jne	<addr>
               	movq	0x10(%r12), %rdi
               	movq	0x8(%r12), %rsi
               	movq	(%r12), %rax
               	movslq	%eax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	cmpq	$0x26, %r15
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r12), %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%r12), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%r15, %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x38(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

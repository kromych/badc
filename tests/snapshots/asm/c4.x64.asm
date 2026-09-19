
c4.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<next>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%r12), %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	leaq	(%rcx,%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%rbx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2f, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x27, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7c, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x26, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5e, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x25, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5b, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	movq	%rax, (%rcx)
               	testq	%rax, %rax
               	jne	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x8f, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0xa4, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x9f, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0xa1, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x93, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x26, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x91, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x94, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7c, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x90, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x92, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x9a, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3e, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x9c, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	$0x98, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x99, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3c, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x9b, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	$0x97, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x96, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0xa3, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x9e, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2b, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0xa2, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x9d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x95, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x8e, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	0x1(%rcx), %rsi
               	movq	%rsi, (%rax)
               	movsbq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	cmpl	$0x5c, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	0x1(%rcx), %rsi
               	movq	%rsi, (%rax)
               	movsbq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0xa, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movb	%al, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x80, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	$0xa0, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	$0x30, %rax
               	movq	%rax, (%rcx)
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x39, %eax
               	jg	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movq	%rdi, (%rcx)
               	movsbq	(%rdx), %rcx
               	addq	%rsi, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x30, %eax
               	jge	<addr>
               	leaq	<rip>, %rax
               	movq	$0x80, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x58, %eax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x66, %rax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x46, %rax
               	jg	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	%rdx, %rdi
               	andq	$0xf, %rdi
               	addq	%rdi, %rsi
               	cmpq	$0x41, %rdx
               	jl	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	addq	%rsi, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movsbq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x37, %eax
               	jg	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movq	%rdi, (%rcx)
               	movsbq	(%rdx), %rcx
               	addq	%rsi, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x1(%rax), %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x41, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x5a, %eax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x30, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x39, %eax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x5f, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0x93, %rcx, %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movq	%rdi, (%rcx)
               	movsbq	(%rdx), %rcx
               	addq	%rsi, %rcx
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
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
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
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rbx, 0x10(%rcx)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x85, (%rcx)
               	movq	$0x85, (%rdx)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<expr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	leaq	<rip>, %rbx
               	cmpq	$0x0, (%rbx)
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	(%rbx), %rax
               	cmpq	%r14, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	(%rbx), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0xd, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%r12, (%rax)
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x8f, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x4, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %r13
               	movq	%r13, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x18, %rax
               	movq	%rax, (%r13)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x2, (%rax)
               	movq	(%r12), %rax
               	leaq	0x8(%rax), %r13
               	movq	%r13, (%r12)
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x90, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x5, (%rax)
               	movq	(%r12), %rax
               	leaq	0x8(%rax), %r13
               	movq	%r13, (%r12)
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x91, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x4, (%rax)
               	movq	(%r12), %rax
               	leaq	0x8(%rax), %r13
               	movq	%r13, (%r12)
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r13)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x92, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xe, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x93, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xf, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x10, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x95, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x11, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x96, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x12, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x97, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x13, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x98, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x14, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x99, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x15, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9a, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x16, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9b, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x17, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x18, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r12, (%rax)
               	cmpq	$0x2, %r12
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1b, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x19, (%rcx)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	cmpq	$0x2, %r12
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1a, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1c, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%r12, (%rax)
               	cmpq	$0x2, %r12
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1b, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1a, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1a, (%rcx)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x1b, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa0, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x1c, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa1, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x1d, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa2, %rax
               	je	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa3, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xa, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rsi
               	movq	%rsi, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rsi)
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	movl	$0x8, %eax
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movq	(%rbx), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movq	$0xd, (%rsi)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	movl	$0x8, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x9, (%rcx)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa4, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x2, %r12
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1b, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x19, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rdx
               	leaq	-0x2(%r12), %rax
               	movq	%rax, (%rdx)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	cmpq	$0x2, %r12
               	jge	<addr>
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	movq	(%rbx), %rax
               	cmpq	%r14, %rax
               	jge	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	(%rbx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x22, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	andq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x2, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x8c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	(%rbx), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movq	%rcx, %rax
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x0, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%r12d, %r12d
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	incq	%r12
               	movq	(%rbx), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x18(%r13), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r13), %rax
               	movq	%rax, (%rcx)
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x7, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r12, (%rcx)
               	leaq	<rip>, %rax
               	movq	0x20(%r13), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	0x18(%r13), %rax
               	cmpq	$0x81, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x3, (%rcx)
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
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	0x18(%r13), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r13), %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	0x18(%r13), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x0, (%rcx)
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
               	leaq	<rip>, %rdx
               	movq	0x20(%r13), %rax
               	movq	%rax, (%rdx)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movq	0x18(%r13), %rax
               	cmpq	$0x83, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
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
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x8a, %rax
               	je	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	movl	$0x1, %r12d
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %r12
               	movq	(%rbx), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	subq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
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
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x0, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x11, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$-0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xf, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rbx), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
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
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$-0x1, (%rax)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	$0x1b, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa2, %rax
               	je	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0xa3, %rax
               	jne	<addr>
               	movq	(%rbx), %r12
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xa, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	movl	$0x8, %ecx
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0xa2, %r12
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x9, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<stmt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x89, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x4, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x87, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movq	%rcx, (%r12)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x2, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x8(%rax), %r13
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x4, (%rax)
               	movq	(%rbx), %rax
               	leaq	0x8(%rax), %r12
               	movq	%r12, (%rbx)
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x2, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	%r13, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x8b, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
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
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
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
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x1(%rdi), %r15
               	leaq	0x8(%rsi), %r14
               	testq	%r15, %r15
               	jle	<addr>
               	movq	(%r14), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2d, %eax
               	jne	<addr>
               	movq	(%r14), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x73, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	decq	%r15
               	addq	$0x8, %r14
               	testq	%r15, %r15
               	jle	<addr>
               	movq	(%r14), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2d, %eax
               	jne	<addr>
               	movq	(%r14), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	decq	%r15
               	addq	$0x8, %r14
               	cmpq	$0x1, %r15
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	(%r14), %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40000, %r10d         # imm = 0x40000
               	movq	%r10, 0x48(%rsp)
               	leaq	<rip>, %r12
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %r12
               	leaq	<rip>, %r13
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r13)
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %r12
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	xorl	%r12d, %r12d
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x86, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x87, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x88, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x89, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8a, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8b, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8c, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8d, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x1e, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x1f, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x20, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x21, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x22, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x23, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x24, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x25, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x26, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	movq	$0x86, (%rax)
               	callq	<addr>
               	movq	(%r12), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %r12
               	leaq	<rip>, %r13
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r13)
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movslq	%ebx, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movl	$0x3ffff, %edx          # imm = 0x3FFFF
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movb	$0x0, (%rcx,%rax)
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x1, %r12d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, 0x18(%rax)
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rbx, 0x20(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x81, 0x18(%rcx)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, 0x28(%rax)
               	callq	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x84, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	%rbx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	leaq	0x1(%r13), %rbx
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movq	%rbx, %r13
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	incq	%r13
               	movq	%r13, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	movl	$0x1, %r12d
               	callq	<addr>
               	jmp	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x84, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	%rbx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	incq	%r13
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x6, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%r13, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x83, 0x18(%rcx)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	%rdx, 0x28(%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%r12d, %r12d
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
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x80, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	leaq	0x1(%r13), %rbx
               	movq	%r13, 0x28(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	%rbx, %r13
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movq	0x38(%rsp), %r10
               	movq	0x28(%r10), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x40(%rsp), %r13
               	addq	0x48(%rsp), %r13
               	leaq	-0x8(%r13), %rcx
               	movq	$0x26, (%rcx)
               	addq	$-0x8, %rcx
               	movq	$0xd, (%rcx)
               	leaq	-0x8(%rcx), %rdx
               	movq	%r15, (%rdx)
               	addq	$-0x8, %rdx
               	movq	%r14, (%rdx)
               	leaq	-0x8(%rdx), %rbx
               	movq	%rcx, (%rbx)
               	xorl	%r15d, %r15d
               	leaq	0x8(%rax), %r14
               	movq	(%rax), %r12
               	incq	%r15
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	(%r12,%r12,4), %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x7, %r12
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rcx
               	shlq	$0x3, %rcx
               	addq	%r13, %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x1, %r12
               	jne	<addr>
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x2, %r12
               	jne	<addr>
               	movq	(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x3, %r12
               	jne	<addr>
               	addq	$-0x8, %rbx
               	leaq	0x8(%r14), %rax
               	movq	%rax, (%rbx)
               	movq	(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x4, %r12
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	leaq	0x8(%r14), %rax
               	jmp	<addr>
               	movq	(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x5, %r12
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movq	(%r14), %rax
               	jmp	<addr>
               	leaq	0x8(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x6, %r12
               	jne	<addr>
               	leaq	-0x8(%rbx), %rcx
               	movq	%r13, (%rcx)
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rdx
               	shlq	$0x3, %rdx
               	movq	%rcx, %rbx
               	subq	%rdx, %rbx
               	movq	%rcx, %r13
               	jmp	<addr>
               	cmpq	$0x7, %r12
               	jne	<addr>
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rbx
               	jmp	<addr>
               	cmpq	$0x8, %r12
               	jne	<addr>
               	leaq	0x8(%r13), %rax
               	movq	(%r13), %r13
               	leaq	0x8(%rax), %rbx
               	movq	(%rax), %rax
               	jmp	<addr>
               	cmpq	$0x9, %r12
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%r14, %rax
               	jmp	<addr>
               	cmpq	$0xa, %r12
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0xb, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0xc, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rcx
               	movq	(%rbx), %rdx
               	movq	-0x8(%rbp), %rax
               	movb	%al, (%rdx)
               	movsbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, %rbx
               	jmp	<addr>
               	cmpq	$0xd, %r12
               	jne	<addr>
               	addq	$-0x8, %rbx
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	cmpq	$0xe, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0xf, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x10, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x11, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x12, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x13, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x14, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setg	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x15, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setle	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x16, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x17, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rdx
               	movq	-0x8(%rbp), %rcx
               	shlq	%cl, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x18, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rdx
               	movq	-0x8(%rbp), %rcx
               	sarq	%cl, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x19, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1a, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1b, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1c, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1d, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rdx
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, -0x8(%rbp)
               	movq	%rdx, %rbx
               	jmp	<addr>
               	cmpq	$0x1e, %r12
               	jne	<addr>
               	movq	0x8(%rbx), %rdi
               	movq	(%rbx), %rax
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x1f, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rax
               	movslq	%eax, %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x20, %r12
               	jne	<addr>
               	movq	(%rbx), %rax
               	movslq	%eax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x21, %r12
               	jne	<addr>
               	movq	0x8(%r14), %rax
               	shlq	$0x3, %rax
               	addq	%rbx, %rax
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
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x22, %r12
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x23, %r12
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	cmpq	$0x24, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rax
               	movslq	%eax, %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x25, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	jmp	<addr>
               	cmpq	$0x26, %r12
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rbx), %rsi
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

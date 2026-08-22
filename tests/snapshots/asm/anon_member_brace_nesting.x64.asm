
anon_member_brace_nesting.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rdi
               	cmpq	%rdi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rdi
               	cmpq	%rdi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rcx), %rdx
               	movslq	0xc(%rax), %rdi
               	cmpq	%rdi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rcx), %rdx
               	movsbq	0x10(%rax), %rdi
               	cmpq	%rdi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rdi
               	movsbq	(%rax), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdi, %rdi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %r8
               	cmpq	%r8, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rdx), %rsi
               	movslq	0xc(%rax), %r8
               	cmpq	%r8, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rdx), %rdx
               	movsbq	0x10(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rsi
               	movsbq	(%rax), %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rax), %r8
               	cmpq	%r8, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0xc(%rdx), %rdi
               	movslq	0xc(%rax), %r8
               	cmpq	%r8, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	0x10(%rdx), %rdx
               	movsbq	0x10(%rax), %rax
               	cmpq	%rax, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0xc(%rcx), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x10(%rcx), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpq	$0x11111111, %rax       # imm = 0x11111111
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	0x4(%rax), %eax
               	cmpq	$0x22222222, %rax       # imm = 0x22222222
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%rdi, %rsi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>

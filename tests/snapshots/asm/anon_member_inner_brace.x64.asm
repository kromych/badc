
anon_member_inner_brace.x64:	file format elf64-x86-64

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
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rcx), %rdx
               	movslq	0xc(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rcx), %rdx
               	movslq	0xc(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdi, %rdi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0xc(%rcx), %rsi
               	movslq	0xc(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdi, %rdi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x10(%rcx), %rsi
               	movslq	0x10(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x14(%rcx), %rcx
               	movslq	0x14(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdi, %rdi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0xc(%rcx), %rsi
               	movslq	0xc(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdi, %rdi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x10(%rcx), %rsi
               	movslq	0x10(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	0x14(%rcx), %rcx
               	movslq	0x14(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
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
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	movzbq	0x8(%rcx), %rcx
               	xorq	$0x7, %rcx
               	movl	%ecx, %edx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0x9(%rcx), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzbq	0xa(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsbq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpq	$0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x8(%rax), %rcx
               	cmpq	$0x3, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x4, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rax), %rcx
               	cmpq	$0x5, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	(%rax), %rdx
               	cmpq	$0x1, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rax), %rdx
               	cmpq	$0x2, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rax), %rdx
               	cmpq	$0x3, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rax), %rdx
               	cmpq	$0x4, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rax), %rcx
               	cmpq	$0x5, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rdx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rcx), %rdx
               	movslq	0xc(%rax), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rcx), %rcx
               	movsbq	0x10(%rax), %rax
               	cmpq	%rax, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
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

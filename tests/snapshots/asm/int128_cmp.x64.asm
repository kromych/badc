
int128_cmp.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	xorl	%r9d, %r9d
               	movq	<rip>, %rdx # <addr>
               	orq	%r9, %rdx
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rsi # <addr>
               	addq	%rsi, %rcx
               	orq	%rcx, %r9
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %r8
               	negq	%r8
               	movq	%rsi, %rcx
               	negq	%rcx
               	movq	<rip>, %rsi # <addr>
               	shlq	$0x3f, %rsi
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	%rdx, %r10
               	xorq	%r9, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x10(%rsp), %r10
               	orq	0x8(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x10(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x10(%rsp)
               	movq	0x10(%rsp), %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%rax, %r10
               	xorq	0x10(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%rax, %r10
               	xorq	0x10(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x10(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpq	%rdi, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x10(%rsp)
               	cmpq	%rdi, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x8(%rsp)
               	cmpq	%r9, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, (%rsp)
               	movq	0x8(%rsp), %r10
               	andq	(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x10(%rsp), %r10
               	orq	0x8(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x10(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	cmpq	%rax, %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x10(%rsp)
               	cmpq	%rax, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rdx, %r9
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdi
               	movq	%rdi, %r10
               	movq	0x10(%rsp), %rdi
               	orq	%r10, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x10(%rsp)
               	andq	0x10(%rsp), %r9
               	orq	%r9, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdx, %rdx
               	seta	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x10(%rsp)
               	andq	0x10(%rsp), %rdi
               	orq	%r9, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	ja	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	testl	%ecx, %ecx
               	setl	%r9b
               	movzbq	%r9b, %r9
               	testl	%ecx, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	0x18(%rsp), %r8
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%rdi, %r10
               	andq	0x10(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	orq	0x10(%rsp), %r9
               	testl	%r9d, %r9d
               	je	<addr>
               	movq	0x18(%rsp), %r9
               	cmpq	%r8, %r9
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpq	%rcx, %rsi
               	setl	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r8, %r8
               	seta	%r8b
               	movzbq	%r8b, %r8
               	andq	%r9, %r8
               	orq	%r8, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	testq	%rsi, %rsi
               	setl	%dil
               	movzbq	%dil, %rdi
               	testq	%rsi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	0x18(%rsp), %r9
               	testq	%r9, %r9
               	seta	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	orq	%r8, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpq	%rsi, %rcx
               	setl	%dil
               	movzbq	%dil, %rdi
               	cmpl	$0x1, %edi
               	je	<addr>
               	testq	%rcx, %rcx
               	jbe	<addr>
               	testq	%rsi, %rsi
               	ja	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rcx
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rcx
               	sete	%dil
               	movzbq	%dil, %rdi
               	orq	%rdi, %r8
               	testl	%r8d, %r8d
               	je	<addr>
               	cmpq	%rsi, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	orq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	<rip>, %rsi # <addr>
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rsi, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rcx, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	testq	%rax, %rax
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	xorq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq

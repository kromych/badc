
int128_cmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %rdx # <addr>
               	orq	%rcx, %rdx
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	addq	%rdi, %rsi
               	orq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rsi, %r11
               	negq	%r11
               	movq	%rdi, %r9
               	negq	%r9
               	movq	<rip>, %rdi # <addr>
               	shlq	$0x3f, %rdi
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x10(%rsp)
               	movq	%rdx, %rsi
               	xorq	%rcx, %rsi
               	movq	%rax, %r10
               	xorq	%r8, %r10
               	orq	%r10, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rsi # <addr>
               	shlq	$0x3f, %rsi
               	xorq	%rax, %rsi
               	xorq	%rax, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpq	%r8, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	cmpq	%r8, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	andq	%rsi, %r10
               	movq	%r11, 0x8(%rsp)
               	movq	0x18(%rsp), %r11
               	orq	%r10, %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x8(%rsp), %r11
               	cmpl	$0x0, 0x18(%rsp)
               	je	<addr>
               	cmpq	%rax, %r8
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rdx, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rsi
               	orq	%rsi, %r8
               	testl	%r8d, %r8d
               	jne	<addr>
               	cmpq	%r9, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r9, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r11, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rcx
               	orq	%rcx, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rax, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	seta	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rcx
               	orq	%rcx, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	ja	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	testl	%r9d, %r9d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	testl	%r9d, %r9d
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	0x10(%rsp), %rcx
               	cmpq	%rcx, %r11
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rsi, %r8
               	orq	%r8, %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	cmpq	%r11, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	cmpq	%r9, %rdi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%r9, %rdi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%r11, %r11
               	seta	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	orq	%rsi, %r8
               	testl	%r8d, %r8d
               	je	<addr>
               	testq	%rdi, %rdi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rsi
               	orq	%rsi, %r8
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpq	%rdi, %r9
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	testq	%r9, %r9
               	jbe	<addr>
               	testq	%rdi, %rdi
               	ja	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
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
               	addq	$0x28, %rsp
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
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq

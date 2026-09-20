
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	xorl	%esi, %esi
               	leaq	<rip>, %r8
               	movq	(%r8), %rcx
               	orq	%rsi, %rcx
               	movq	(%rdx), %rdi
               	movq	(%r8), %rdx
               	leaq	<rip>, %r9
               	movq	(%r9), %r8
               	addq	%r8, %rdx
               	movq	%rsi, %rbx
               	orq	%rdx, %rbx
               	movq	(%r9), %rdx
               	testq	%rdx, %rdx
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %r8
               	negq	%r8
               	movq	%rsi, %rdx
               	negq	%rdx
               	movq	(%r9), %rsi
               	shlq	$0x3f, %rsi
               	movq	(%r9), %r9
               	movq	%rcx, %r12
               	xorq	%rcx, %r12
               	movq	%rax, %r13
               	xorq	%rax, %r13
               	orq	%r13, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movq	%rcx, %r12
               	xorq	%rcx, %r12
               	movq	%rax, %r13
               	xorq	%rax, %r13
               	orq	%r13, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%rcx, %r12
               	xorq	%rbx, %r12
               	movq	%rax, %r13
               	xorq	%rdi, %r13
               	orq	%r13, %r12
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	shlq	$0x3f, %r12
               	xorq	%rax, %r12
               	movq	%rcx, %r13
               	xorq	%rcx, %r13
               	xorq	%rax, %r12
               	orq	%r13, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	cmpq	%rdi, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rdi, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	%rbx, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r12
               	testl	%r12d, %r12d
               	je	<addr>
               	cmpq	%rax, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rax, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rbx
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rdi
               	orq	%r12, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpq	%rdx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rdx, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r8, %rcx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rax, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rax, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rcx, %rcx
               	seta	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rdi
               	orq	%rbx, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rbx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	testq	%rdi, %rdi
               	seta	%r12b
               	movzbq	%r12b, %r12
               	testq	%rdi, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rbx, %rbx
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rdi
               	orq	%r12, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	testl	%edx, %edx
               	setl	%bl
               	movzbq	%bl, %rbx
               	testl	%edx, %edx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r9, %r8
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%rdi, %r12
               	orq	%r12, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	cmpq	%r8, %r9
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpq	%rdx, %rsi
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rdx, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%r8, %r8
               	seta	%r12b
               	movzbq	%r12b, %r12
               	andq	%rdi, %r12
               	orq	%r12, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	testq	%rsi, %rsi
               	setl	%bl
               	movzbq	%bl, %rbx
               	testq	%rsi, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%r9, %r9
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %rbx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	cmpq	%rsi, %rdx
               	setl	%bl
               	movzbq	%bl, %rbx
               	testq	%r8, %r8
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	testq	%rdx, %rdx
               	jbe	<addr>
               	testq	%rsi, %rsi
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%r9, %r9
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	orq	%rsi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rdi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	orq	%r8, %r9
               	testl	%r9d, %r9d
               	je	<addr>
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	orq	%r8, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r8
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rax, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%rdi, %r8
               	orq	%r9, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movq	(%rdx), %rdx
               	testq	%rax, %rax
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rdi, %rcx
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movq	(%rsi), %rax
               	movq	(%rsi), %rcx
               	xorq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

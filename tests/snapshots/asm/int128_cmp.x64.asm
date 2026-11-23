
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	xorl	%esi, %esi
               	movq	<rip>, %rcx # <addr>
               	orq	%rsi, %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	addq	%r8, %rdi
               	orq	%rsi, %rdi
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rsi, %r10
               	negq	%r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r8, %rsi
               	negq	%rsi
               	movq	<rip>, %r8 # <addr>
               	shlq	$0x3f, %r8
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	%rcx, %r9
               	xorq	%rdi, %r9
               	movq	%rax, %rbx
               	xorq	%rdx, %rbx
               	orq	%rbx, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %r9 # <addr>
               	shlq	$0x3f, %r9
               	xorq	%rax, %r9
               	xorq	%rax, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	%rdx, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rdx, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rdi, %rcx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x20(%rsp)
               	andq	0x20(%rsp), %rbx
               	orq	%rbx, %r9
               	testl	%r9d, %r9d
               	je	<addr>
               	cmpq	%rax, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rcx, %rdi
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rdx
               	orq	%r9, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	cmpq	%rsi, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	0x28(%rsp), %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdi
               	orq	%rdi, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	seta	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	%rdi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	ja	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	testl	%esi, %esi
               	setl	%bl
               	movzbq	%bl, %rbx
               	testl	%esi, %esi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	0x28(%rsp), %rdx
               	movq	0x18(%rsp), %rdi
               	cmpq	%rdi, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r9, %r10
               	andq	0x28(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	cmpq	%rdx, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	testl	%r9d, %r9d
               	jne	<addr>
               	cmpq	%rsi, %r8
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %r8
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rdx, %rdx
               	seta	%dl
               	movzbq	%dl, %rdx
               	andq	%rbx, %rdx
               	orq	%r9, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	testq	%r8, %r8
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%r8, %r8
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%r9, %rdi
               	orq	%rdi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	%r8, %rsi
               	setl	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	testq	%rsi, %rsi
               	jbe	<addr>
               	testq	%r8, %r8
               	ja	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rdx
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rdx
               	sete	%dil
               	movzbq	%dil, %rdi
               	orq	%rdi, %r8
               	testl	%r8d, %r8d
               	je	<addr>
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	orq	%rdi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rsi # <addr>
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rsi, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rdx, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	testq	%rax, %rax
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq

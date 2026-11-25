
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
               	subq	$0x30, %rsp
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %rdx # <addr>
               	orq	%rcx, %rdx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	addq	%r8, %rdi
               	orq	%rdi, %rcx
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %r10
               	negq	%r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r8, %r9
               	negq	%r9
               	movq	<rip>, %r8 # <addr>
               	shlq	$0x3f, %r8
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	%rdx, %rdi
               	xorq	%rcx, %rdi
               	movq	%rax, %rbx
               	xorq	%rsi, %rbx
               	orq	%rbx, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	shlq	$0x3f, %rdi
               	xorq	%rax, %rdi
               	xorq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	cmpq	%rsi, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rdx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x20(%rsp)
               	andq	0x20(%rsp), %rdi
               	orq	%rdi, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	cmpq	%rax, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rsi
               	orq	%rsi, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpq	%r9, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r9, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	0x28(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rcx
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
               	seta	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rcx
               	orq	%rcx, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	ja	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	testl	%r9d, %r9d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x20(%rsp)
               	testl	%r9d, %r9d
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	0x28(%rsp), %rcx
               	movq	0x18(%rsp), %rsi
               	cmpq	%rsi, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rdi, %rbx
               	movq	0x20(%rsp), %r10
               	orq	%rbx, %r10
               	movq	%r10, 0x20(%rsp)
               	testl	%r10d, %r10d
               	je	<addr>
               	cmpq	%rcx, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpq	%r9, %r8
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %r8
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rcx, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rdi
               	orq	%rdi, %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	testq	%r8, %r8
               	setl	%dil
               	movzbq	%dil, %rdi
               	testq	%r8, %r8
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rsi, %rsi
               	seta	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rcx
               	orq	%rcx, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	cmpq	%r8, %r9
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	testq	%r9, %r9
               	jbe	<addr>
               	testq	%r8, %r8
               	ja	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
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
               	popq	%rbx
               	addq	$0x30, %rsp
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
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq

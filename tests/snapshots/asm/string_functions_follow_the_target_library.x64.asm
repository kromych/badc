
string_functions_follow_the_target_library.x64:	file format elf64-x86-64

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
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	leaq	0x68(%rsp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	0x70(%rsp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x68(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setl	%r13b
               	movzbq	%r13b, %r13
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movq	%rbx, %rsi
               	movq	%r13, %r9
               	movq	%r12, %rcx
               	leaq	<rip>, %rdi
               	leaq	0xa0(%rsp), %rdx
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x6f, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x6f, %esi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movq	%rbx, %rsi
               	movq	%r15, %r9
               	movq	%r14, %r8
               	movq	%r13, %rcx
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x7a, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	0xa0(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	leaq	0xd(%rdi), %rcx
               	cmpq	%rcx, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xa0(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	%rax, %r12
               	movb	$0x48, (%rbx)
               	movq	%rbx, %rsi
               	movq	%r12, %rcx
               	leaq	<rip>, %rdi
               	leaq	0xa0(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	0x90(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movzwq	0x8(%rax), %r10
               	movw	%r10w, 0x8(%rdi)
               	movzbq	0xa(%rax), %r10
               	movb	%r10b, 0xa(%rdi)
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	nopl	(%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	<rip>, %rsi
               	leaq	0x78(%rsp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	nopl	(%rax)
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	0x78(%rsp), %rdx
               	callq	<addr>
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x88(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	movsbq	0x8a(%rsp), %rsi
               	movsbq	0x8b(%rsp), %rdx
               	movsbq	0x8c(%rsp), %rcx
               	movsbq	0x8d(%rsp), %r8
               	leaq	<rip>, %rdi
               	leaq	0x88(%rsp), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x64, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x1, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x78, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movl	$0x21, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movl	$0x71, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	movl	$0x51, %edi
               	callq	<addr>
               	movq	%rax, %rbp
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movl	$0xe9, %edi
               	callq	<addr>
               	movq	%rbp, (%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rbx, %rsi
               	movq	%r15, %r9
               	movq	%r14, %r8
               	movq	%r13, %rcx
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x61, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x35, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x20, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x98, %rsp
               	retq

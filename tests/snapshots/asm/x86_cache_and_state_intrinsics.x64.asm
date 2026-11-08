
x86_cache_and_state_intrinsics.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorl	%r8d, %r8d
               	movl	$0x5, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r10
               	clflushopt	(%r10)
               	leaq	-0x10(%rbp), %r10
               	prefetchw	(%r10)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %r8d
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %r10
               	fxsave	(%r10)
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movzbq	(%rsi,%rcx), %rdi
               	orq	%rdi, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	cmpl	$0x37f, %edx            # imm = 0x37F
               	jne	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %ecx
               	shlq	$0x8, %rdx
               	leaq	0x18(%rcx), %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	andq	$0xffc0, %rdx           # imm = 0xFFC0
               	cmpl	$0x1f80, %edx           # imm = 0x1F80
               	jne	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %ecx
               	shlq	$0x8, %rdx
               	leaq	0x1c(%rcx), %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	orq	$0x2, %r8
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %r10
               	fxrstor	(%r10)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	andq	$0xffc0, %rax           # imm = 0xFFC0
               	cmpl	$0x1f80, %eax           # imm = 0x1F80
               	je	<addr>
               	orq	$0x4, %r8
               	movq	%r8, %rax
               	leave
               	retq

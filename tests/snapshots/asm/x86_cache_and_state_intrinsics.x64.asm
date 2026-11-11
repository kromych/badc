
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
               	xorl	%eax, %eax
               	movl	$0x5, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r10
               	clflushopt	(%r10)
               	leaq	-0x10(%rbp), %r10
               	prefetchw	(%r10)
               	movl	-0x10(%rbp), %ecx
               	movl	$0x1, %edx
               	cmpl	$0x5, %ecx
               	movq	%rax, %rdi
               	cmovneq	%rdx, %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %r10
               	fxsave	(%r10)
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdx,%rax), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x37f, %ecx            # imm = 0x37F
               	jne	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	andq	$0xffc0, %rcx           # imm = 0xFFC0
               	cmpl	$0x1f80, %ecx           # imm = 0x1F80
               	jne	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	orq	$0x2, %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %r10
               	fxrstor	(%r10)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	andq	$0xffc0, %rax           # imm = 0xFFC0
               	movq	%rdi, %rcx
               	orq	$0x4, %rcx
               	cmpl	$0x1f80, %eax           # imm = 0x1F80
               	movq	%rdi, %rax
               	cmovneq	%rcx, %rax
               	leave
               	retq

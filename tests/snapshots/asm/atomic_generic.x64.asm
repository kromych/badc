
atomic_generic.x64:	file format elf64-x86-64

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
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	-0x8(%rbp), %rsi
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0xdeadbeefcafe, %rsi   # imm = 0xDEADBEEFCAFE
               	movq	%rsi, -0x8(%rbp)
               	movq	(%rdx), %rsi
               	movq	%rsi, (%rcx)
               	movq	-0x10(%rbp), %rsi
               	movabsq	$0xdeadbeefcafe, %r11   # imm = 0xDEADBEEFCAFE
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %esi
               	movl	%esi, -0x10(%rbp)
               	movl	%eax, -0x8(%rbp)
               	movslq	(%rcx), %rax
               	movl	%eax, (%rdx)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	movabsq	$-0x7, %rcx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	movl	%esi, (%rcx)
               	movslq	-0x10(%rbp), %rsi
               	cmpl	$-0x7, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1000, %esi           # imm = 0x1000
               	movq	%rsi, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rdx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x1000, %rcx           # imm = 0x1000
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq

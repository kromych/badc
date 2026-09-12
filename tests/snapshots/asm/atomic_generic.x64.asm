
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
               	subq	$0x30, %rsp
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x28(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rcx), %rdx
               	leaq	-0x30(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	-0x30(%rbp), %rdx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, -0x20(%rbp)
               	movabsq	$0xdeadbeefcafe, %rdx   # imm = 0xDEADBEEFCAFE
               	movq	%rdx, -0x30(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rcx), %rsi
               	movq	%rsi, %r10
               	xchgq	%r10, (%rdx)
               	movq	-0x20(%rbp), %rdx
               	movabsq	$0xdeadbeefcafe, %r11   # imm = 0xDEADBEEFCAFE
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	movl	(%rdx), %edx
               	movl	%edx, (%rcx)
               	movslq	-0x30(%rbp), %rdx
               	cmpl	$0x2a, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	%eax, -0x10(%rbp)
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rcx), %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1000, %eax           # imm = 0x1000
               	movq	%rax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	-0x30(%rbp), %rcx
               	cmpq	$0x1000, %rcx           # imm = 0x1000
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq

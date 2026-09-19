
struct_arg_two_eightbyte.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movl	$0x9, (%rax)
               	leaq	<rip>, %rsi
               	movq	$0x1111, (%rsi)         # imm = 0x1111
               	leaq	<rip>, %rdi
               	movl	$0x4, (%rdi)
               	leaq	<rip>, %r8
               	movq	$0x2222, (%r8)          # imm = 0x2222
               	leaq	<rip>, %r9
               	movl	$0x6, (%r9)
               	movslq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rsi), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	jne	<addr>
               	movl	(%rdi), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%r8), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	$0x1111, (%rax)         # imm = 0x1111
               	leaq	<rip>, %rcx
               	movl	$0x4, %esi
               	movl	%esi, (%rcx)
               	leaq	<rip>, %rdi
               	movq	$0x2222, (%rdi)         # imm = 0x2222
               	leaq	<rip>, %rdx
               	movl	$0x6, (%rdx)
               	movq	(%rax), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	jne	<addr>
               	movl	(%rcx), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	movq	(%rdi), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	movl	(%rdx), %eax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq


struct_field_assign_from_call.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movl	$0x4, %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	$0x1234abcd, %edx       # imm = 0x1234ABCD
               	movq	%rdx, 0x8(%rax)
               	movl	%ecx, 0x24(%rax)
               	movq	%rdx, 0x18(%rax)
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ecx, %rsi
               	movq	0x8(%rax), %rdx
               	movq	0x18(%rax), %rcx
               	movslq	0x14(%rax), %r8
               	movslq	0x24(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movq	0x18(%rax), %rdx
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	cmpq	$0x1234abcd, %rdx       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movq	0x18(%rax), %rdx
               	cmpq	$0x1234abcd, %rdx       # imm = 0x1234ABCD
               	je	<addr>
               	jmp	<addr>
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x5, %ecx
               	jmp	<addr>
               	movslq	0x24(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x6, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>

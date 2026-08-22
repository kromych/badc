
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
               	movq	0x8(%rax), %rdx
               	movq	0x18(%rax), %rsi
               	movl	$0x4, %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	$0x1234abcd, %ecx       # imm = 0x1234ABCD
               	movq	%rcx, 0x8(%rax)
               	movl	$0x4, %edi
               	movl	%edi, 0x24(%rax)
               	movl	$0x1234abcd, %edi       # imm = 0x1234ABCD
               	movq	%rdi, 0x18(%rax)
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rdx
               	testq	%rdx, %rdx
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
               	movq	0x18(%rax), %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x1234abcd, %rcx       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	$0x1234abcd, %rcx       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movslq	0x14(%rax), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x5, %ecx
               	jmp	<addr>
               	movslq	0x24(%rax), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x6, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>

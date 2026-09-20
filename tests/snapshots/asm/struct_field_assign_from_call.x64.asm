
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
               	movl	$0x4, 0x14(%rax)
               	movq	$0x1234abcd, 0x8(%rax)  # imm = 0x1234ABCD
               	movl	$0x4, 0x24(%rax)
               	movq	$0x1234abcd, 0x18(%rax) # imm = 0x1234ABCD
               	cmpq	$0x1234abcd, %rsi       # imm = 0x1234ABCD
               	jne	<addr>
               	movl	$0x1, %esi
               	testl	%esi, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	0x8(%rax), %rdx
               	movq	0x18(%rax), %rcx
               	movslq	0x14(%rax), %r8
               	movslq	0x24(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	cmpq	$0x1234abcd, %rdi       # imm = 0x1234ABCD
               	jne	<addr>
               	movl	$0x2, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>

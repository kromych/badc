
libc_fp_classify.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0x7f800000, 0x8(%rsp)  # imm = 0x7F800000
               	movl	0x8(%rsp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x7fc00000, 0x8(%rsp)  # imm = 0x7FC00000
               	movl	0x8(%rsp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>


memory_ops.x64:	file format elf64-x86-64

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
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$0x4141414141414141, %rax # imm = 0x4141414141414141
               	movq	%rax, (%r12)
               	movw	$0x41, 0x8(%r12)
               	movq	%rax, (%rbx)
               	movw	$0x41, 0x8(%rbx)
               	movl	$0xa, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movb	$0x42, 0x5(%rbx)
               	movl	$0xa, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

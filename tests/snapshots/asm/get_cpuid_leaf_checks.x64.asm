
get_cpuid_leaf_checks.x64:	file format elf64-x86-64

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
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	movl	$0xa5a5a5a5, -0x8(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x10(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x18(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x20(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x68(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x70(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x78(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0x80(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0xc8(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0xd0(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0xd8(%rbp) # imm = 0xA5A5A5A5
               	movl	$0xa5a5a5a5, -0xe0(%rbp) # imm = 0xA5A5A5A5
               	xorl	%eax, %eax
               	leave
               	retq

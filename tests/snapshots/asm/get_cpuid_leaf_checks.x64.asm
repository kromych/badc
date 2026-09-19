
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
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x68(%rbp)
               	movl	%eax, -0x70(%rbp)
               	movl	%eax, -0x78(%rbp)
               	movl	%eax, -0x80(%rbp)
               	movl	%eax, -0xc8(%rbp)
               	movl	%eax, -0xd0(%rbp)
               	movl	%eax, -0xd8(%rbp)
               	movl	%eax, -0xe0(%rbp)
               	xorl	%eax, %eax
               	leave
               	retq

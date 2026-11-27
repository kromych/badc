
local_array_runtime_init.x64:	file format elf64-x86-64

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
               	movw	$0x1234, <rip> # imm = 0x1234
                                                # <addr>
               	movl	$0x5678, %eax           # imm = 0x5678
               	movw	%ax, <rip> # <addr>
               	movzwq	<rip>, %rcx # <addr>
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	cmpl	$0x477198, %eax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

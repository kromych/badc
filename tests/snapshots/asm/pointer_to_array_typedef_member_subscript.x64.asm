
pointer_to_array_typedef_member_subscript.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rax
               	orq	$0x240, %rax            # imm = 0x240
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rax
               	orq	$0x140, %rax            # imm = 0x140
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x6, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	sarq	$0x6, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq

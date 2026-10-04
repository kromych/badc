
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
               	leaq	<rip>, %rax      # <addr>
               	movl	0x808(%rax), %ecx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rcx
               	orq	$0x240, %rcx            # imm = 0x240
               	movl	%ecx, 0x808(%rax)
               	movl	0x80c(%rax), %ecx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rcx
               	orq	$0x140, %rcx            # imm = 0x140
               	movl	%ecx, 0x80c(%rax)
               	leaq	0x800(%rax), %rcx
               	movl	0x8(%rcx), %ecx
               	sarq	$0x6, %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	0x80c(%rax), %eax
               	sarq	$0x6, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq


packed_member_read_through_a_pointer.x64:	file format elf64-x86-64

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

<read_word>:
               	movl	<rip>, %eax # <addr>
               	retq

<write_wide>:
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, <rip> # <addr>
               	retq

<read_first>:
               	movl	<rip>, %eax # <addr>
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	cmpl	$0xbadcafe, %eax        # imm = 0xBADCAFE
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movabsq	$0x102030405060708, %rdi # imm = 0x102030405060708
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x4321, %eax           # imm = 0x4321
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq

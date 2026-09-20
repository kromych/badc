
return_narrows_to_type_width.x64:	file format elf64-x86-64

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

<uret>:
               	movl	$0x92000007, %eax       # imm = 0x92000007
               	retq

<sret>:
               	movq	$-0x80000000, %rax      # imm = 0x80000000
               	retq

<hret>:
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movl	$0x92000007, %r11d      # imm = 0x92000007
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1ffff, %edi          # imm = 0x1FFFF
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

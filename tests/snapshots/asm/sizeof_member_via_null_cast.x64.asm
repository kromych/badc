
sizeof_member_via_null_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	jmp	<addr>
               	movl	$0xb, %eax
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	retq
               	jmp	<addr>
               	movl	$0xd, %eax
               	retq
               	jmp	<addr>
               	movl	$0xe, %eax
               	retq
               	jmp	<addr>
               	movl	$0xf, %eax
               	retq
               	jmp	<addr>
               	movl	$0x10, %eax
               	retq
               	jmp	<addr>
               	movl	$0x11, %eax
               	retq
               	xorq	%rax, %rax
               	retq

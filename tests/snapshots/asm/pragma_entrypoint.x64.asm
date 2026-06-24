
pragma_entrypoint.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<custom_entry>:
               	movl	$0x17, %eax
               	retq
               	addb	%al, (%rax)

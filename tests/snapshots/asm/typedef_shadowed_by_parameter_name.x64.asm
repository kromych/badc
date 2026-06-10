
typedef_shadowed_by_parameter_name.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	jmp	<addr>
               	movl	$0xb, %eax
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	retq
               	jmp	<addr>
               	movl	$0xd, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)

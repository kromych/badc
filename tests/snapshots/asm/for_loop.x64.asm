
for_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	cmpq	$0x5, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	movslq	%eax, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	retq

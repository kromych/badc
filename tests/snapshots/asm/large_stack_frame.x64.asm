
large_stack_frame.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x230, %esi            # imm = 0x230
               	callq	<addr>
               	ud2
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x28, %eax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, 0x41(%rdx)

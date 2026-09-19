
inline_phi_narrow_param_return.x64:	file format elf64-x86-64

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
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	cmpl	$0x32, %eax
               	jge	<addr>
               	imulq	$0xf4243, %rcx, %rcx    # imm = 0xF4243
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x32, %eax
               	jl	<addr>
               	cmpq	$-0x4728dfba, %rcx      # imm = 0xB8D72046
               	jne	<addr>
               	xorl	%eax, %eax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

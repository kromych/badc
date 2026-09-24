
inline_asm_clobber_probe.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1234, %esi           # imm = 0x1234
               	movl	$0x0, %eax
               	movl	$0x0, %ebx
               	movl	$0x0, %ecx
               	movl	$0x0, %edx
               	movq	%rsi, %rax
               	cmpl	$0x1234, %eax           # imm = 0x1234
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

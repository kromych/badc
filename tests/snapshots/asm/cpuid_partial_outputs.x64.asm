
cpuid_partial_outputs.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	cpuid
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movl	%edx, -0x28(%rbp)
               	cmpl	%eax, %esi
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

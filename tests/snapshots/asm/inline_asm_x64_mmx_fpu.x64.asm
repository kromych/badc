
inline_asm_x64_mmx_fpu.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	%mm0, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %mm1
               	movq	%mm2, %mm3
               	movq	%mm4, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %mm5
               	fninit
               	wait
               	emms
               	movq	-0x10(%rbp), %rax
               	movslq	%eax, %rax
               	leave
               	retq

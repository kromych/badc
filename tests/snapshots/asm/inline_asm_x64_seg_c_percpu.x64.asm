
inline_asm_x64_seg_c_percpu.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %r10
               	movq	%gs:<rip>, %rax
               	movq	%gs:<rip>, %rcx
               	addq	%rcx, %rax
               	movb	%gs:0x10, %cl
               	movw	%gs:0x12, %dx
               	movl	%gs:0x14, %esi
               	movq	%gs:0x18, %rdi
               	andq	$0xff, %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	movl	%esi, %edx
               	addq	%rdx, %rcx
               	addq	%rdi, %rcx
               	incq	%rcx
               	addq	%rcx, %rax
               	movq	%fs:0x28, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %gs:0x20
               	movl	%eax, %ecx
               	movl	%ecx, %gs:0x28
               	addq	%rax, %gs:0x20
               	incq	%gs:0x30
               	cmpq	%rax, %gs:0x38
               	leaq	<rip>, %r10
               	nop
               	movl	$0x2a, %eax
               	retq
               	addb	%al, (%rax)
               	movq	%gs:0x40, %rax
               	movq	%gs:<rip>, %rdx

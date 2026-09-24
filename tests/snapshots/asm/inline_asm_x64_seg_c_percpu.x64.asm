
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movq	%gs:<rip>, %rax
               	movq	%rax, %rcx
               	movq	%gs:<rip>, %rax
               	addq	%rax, %rcx
               	movb	%gs:0x10, %al
               	movq	%rax, %rdx
               	movw	%gs:0x12, %ax
               	movq	%rax, %rsi
               	movl	%gs:0x14, %eax
               	movq	%rax, %rdi
               	movq	%gs:0x18, %rax
               	andq	$0xff, %rdx
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	addq	%rsi, %rdx
               	movl	%edi, %esi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	incq	%rax
               	addq	%rax, %rcx
               	movq	%fs:0x28, %rax
               	addq	%rax, %rcx
               	movq	%rcx, %rax
               	movq	%rax, %gs:0x20
               	movl	%ecx, %eax
               	movl	%eax, %gs:0x28
               	movq	%rcx, %rax
               	addq	%rax, %gs:0x20
               	incq	%gs:0x30
               	movq	%rcx, %rax
               	cmpq	%rax, %gs:0x38
               	leaq	<rip>, %rbx
               	nop
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	addb	%al, (%rax)
               	movq	%gs:0x40, %rax
               	movq	%gs:<rip>, %rdx

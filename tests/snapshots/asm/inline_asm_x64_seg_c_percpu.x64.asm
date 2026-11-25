
inline_asm_x64_seg_c_percpu.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movslq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %r10 # <addr>
               	movq	%gs:<rip>, %rax
               	movq	%gs:<rip>, %rcx
               	leaq	(%rax,%rcx), %rdx
               	movb	%gs:0x10, %al
               	movw	%gs:0x12, %cx
               	movl	%gs:0x14, %esi
               	movq	%gs:0x18, %rdi
               	andq	$0xff, %rax
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	movl	%esi, %ecx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	incq	%rax
               	addq	%rdx, %rax
               	movq	%fs:0x28, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %gs:0x20
               	movl	%eax, %ecx
               	movl	%ecx, %gs:0x28
               	addq	%rax, %gs:0x20
               	incq	%gs:0x30
               	cmpq	%rax, %gs:0x38
               	leaq	<rip>, %r10 # <addr>
               	nop
               	movl	$0x2a, %eax
               	retq
               	addb	%ah, 0x48(%rbp)
               	movl	0x40, %eax
               	movq	%gs:<rip>, %rdx

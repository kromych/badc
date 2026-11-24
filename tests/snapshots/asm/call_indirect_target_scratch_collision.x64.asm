
call_indirect_target_scratch_collision.x64:	file format elf64-x86-64

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

<sink_op>:
               	xorl	%eax, %eax
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%r8)
               	retq

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	leaq	0x10(%rsp), %rdi
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x10(%rsp)
               	xorl	%edx, %edx
               	movl	%edx, 0x18(%rsp)
               	leaq	<rip>, %rsi
               	leaq	0x18(%rsp), %r8
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movl	0x18(%rsp), %edx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	$0x10040, %eax          # imm = 0x10040
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

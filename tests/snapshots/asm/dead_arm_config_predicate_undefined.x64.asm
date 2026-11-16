
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

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

<dispatch>:
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rax
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%eax, %eax
               	cmoveq	%rsi, %rdx
               	leaq	(%rcx,%rdx), %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq

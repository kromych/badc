
x86_system_builtins_read_the_processor.x64:	file format elf64-x86-64

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
               	sfence
               	lfence
               	mfence
               	pause
               	rdtsc
               	movl	%eax, %eax
               	shlq	$0x20, %rdx
               	movq	%rdx, %rcx
               	orq	%rax, %rcx
               	rdtsc
               	movl	%eax, %eax
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	testl	$0x8000000, %ecx        # imm = 0x8000000
               	je	<addr>
               	xorl	%ecx, %ecx
               	xgetbv
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	andq	$0x3, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	pushfq
               	popq	%rax
               	testb	$0x2, %al
               	je	<addr>
               	testl	$0x200, %eax            # imm = 0x200
               	je	<addr>
               	testl	$0x400, %eax            # imm = 0x400
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

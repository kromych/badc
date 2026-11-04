
x86_system_wrappers_execute.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	sfence
               	lfence
               	mfence
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	movq	%r10, %rcx
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
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	movq	%r10, %rcx
               	cpuid
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	cmpl	%r11d, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	movl	$0x80000001, %ecx       # imm = 0x80000001
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	movq	%r10, %rcx
               	cpuid
               	testl	$0x8000000, %edx        # imm = 0x8000000
               	je	<addr>
               	movl	$0xdeadbeef, -0x8(%rbp) # imm = 0xDEADBEEF
               	rdtscp
               	movl	%ecx, -0x8(%rbp)
               	movl	%eax, %eax
               	shlq	$0x20, %rdx
               	movq	%rdx, %rsi
               	orq	%rax, %rsi
               	rdtscp
               	movl	%eax, %eax
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movl	-0x8(%rbp), %edx
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpl	%r11d, %ecx
               	je	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
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
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rcx
               	xorq	$0x200000, %rcx         # imm = 0x200000
               	pushq	%rcx
               	popfq
               	pushfq
               	popq	%rcx
               	pushq	%rax
               	popfq
               	xorq	%rax, %rcx
               	testl	$0x200000, %ecx         # imm = 0x200000
               	je	<addr>
               	pushfq
               	popq	%rcx
               	xorq	%rcx, %rax
               	testl	$0x200000, %eax         # imm = 0x200000
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

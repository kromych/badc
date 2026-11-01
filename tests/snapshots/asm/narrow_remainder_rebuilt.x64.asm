
narrow_remainder_rebuilt.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %esi
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rdx, %rbx
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx), %esi
               	andq	$0x4, %rsi
               	andq	%rbx, %rsi
               	movl	(%rcx,%rsi,4), %esi
               	movl	%esi, (%rax)
               	movl	(%rdx), %edx
               	andq	$0x4, %rdx
               	andq	%rbx, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx), %esi
               	andq	$0x4, %rsi
               	andq	%rbx, %rsi
               	movl	(%rcx,%rsi,4), %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rdx), %esi
               	andq	$0x4, %rsi
               	andq	%rbx, %rsi
               	movl	(%rcx,%rsi,4), %esi
               	movl	%esi, (%rax)
               	movl	(%rdx), %edx
               	andq	$0x4, %rdx
               	andq	%rbx, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx), %esi
               	andq	$0x4, %rsi
               	andq	%rbx, %rsi
               	movl	(%rcx,%rsi,4), %esi
               	movl	%esi, (%rax)
               	movl	(%rdx), %edx
               	andq	$0x4, %rdx
               	andq	%rbx, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx), %edx
               	andq	$0x4, %rdx
               	andq	%rbx, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	$0x3, %rbx
               	testl	%ebx, %ebx
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq

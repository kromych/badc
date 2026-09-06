
kernel_asm_call_const_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<local_target>:
               	endbr64
               	xorq	%rax, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<run_external>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	irq_stack_ptr
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	external_target
               	movq	-0x8(%rbp), %rsi
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	(%r10), %r11
               	movq	-0x18(%rbp), %r11
               	movq	%rsp, (%r11)
               	movq	%r11, %rsp
               	callq	<addr>
		R_X86_64_PLT32	external_target-0x4
               	popq	%rsp
               	movq	-0x30(%rbp), %r10
               	movq	%r11, (%r10)
               	xorq	%rax, %rax
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<run_local>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	irq_stack_ptr
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	leaq	(%rip), %rdx            # <addr>
		R_X86_64_PC32	.text-0x4
               	movq	-0x8(%rbp), %rsi
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	(%r10), %r11
               	movq	-0x18(%rbp), %r11
               	movq	%rsp, (%r11)
               	movq	%r11, %rsp
               	callq	<addr>
               	popq	%rsp
               	movq	-0x30(%rbp), %r10
               	movq	%r11, (%r10)
               	xorq	%rax, %rax
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<jump_external>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	external_target
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
		R_X86_64_PLT32	external_target-0x4
               	xorq	%rax, %rax
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

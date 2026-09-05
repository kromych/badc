
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
               	subq	$0x80, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	irq_stack_ptr
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	external_target
               	movq	-0x8(%rbp), %rsi
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	%rdi, -0x60(%rbp)
               	movq	%r8, -0x58(%rbp)
               	movq	%r9, -0x50(%rbp)
               	movq	%r10, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	-0x38(%rbp), %r10
               	movq	(%r10), %r11
               	movq	-0x20(%rbp), %r11
               	movq	%rsp, (%r11)
               	movq	%r11, %rsp
               	callq	<addr>
		R_X86_64_PLT32	external_target-0x4
               	popq	%rsp
               	movq	-0x38(%rbp), %r10
               	movq	%r11, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rsi
               	movq	-0x60(%rbp), %rdi
               	movq	-0x58(%rbp), %r8
               	movq	-0x50(%rbp), %r9
               	movq	-0x48(%rbp), %r10
               	movq	-0x40(%rbp), %r11
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<run_local>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	irq_stack_ptr
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	leaq	(%rip), %rdx            # <addr>
		R_X86_64_PC32	.text-0x4
               	movq	-0x8(%rbp), %rsi
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	%rdi, -0x60(%rbp)
               	movq	%r8, -0x58(%rbp)
               	movq	%r9, -0x50(%rbp)
               	movq	%r10, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	-0x38(%rbp), %r10
               	movq	(%r10), %r11
               	movq	-0x20(%rbp), %r11
               	movq	%rsp, (%r11)
               	movq	%r11, %rsp
               	callq	<addr>
               	popq	%rsp
               	movq	-0x38(%rbp), %r10
               	movq	%r11, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rsi
               	movq	-0x60(%rbp), %rdi
               	movq	-0x58(%rbp), %r8
               	movq	-0x50(%rbp), %r9
               	movq	-0x48(%rbp), %r10
               	movq	-0x40(%rbp), %r11
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

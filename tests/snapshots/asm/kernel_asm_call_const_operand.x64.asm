
kernel_asm_call_const_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<local_target>:
               	endbr64
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<run_external>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	irq_stack_ptr
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rsp, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	-0x8(%rbp), %r11
               	movq	%rsp, (%r11)
               	movq	%r11, %rsp
               	callq	<addr>
		R_X86_64_PLT32	external_target-0x4
               	popq	%rsp
               	movq	%r11, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rsp
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<run_local>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, %rax
		R_X86_64_32S	irq_stack_ptr
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rsp, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	-0x8(%rbp), %r11
               	movq	%rsp, (%r11)
               	movq	%r11, %rsp
               	callq	<addr>
               	popq	%rsp
               	movq	%r11, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rsp
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<jump_external>:
               	endbr64
               	jmp	<addr>
		R_X86_64_PLT32	external_target-0x4
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
